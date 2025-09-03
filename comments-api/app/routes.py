from flask import request, jsonify
from app import create_app, db
from app.models import Comment
from prometheus_client import generate_latest, Counter, Histogram
from sqlalchemy import text
import time

REQUEST_COUNTER = Counter('http_requests_total', 'Total de requisições HTTP', ['method', 'endpoint', 'status_code'])
REQUEST_LATENCY = Histogram('http_request_duration_seconds', 'HTTP request latency', ['method', 'endpoint'])

def init_app_routes(app):
    @app.before_request
    def start_timer():
        request.start_time = time.time()

    @app.after_request
    def record_request_data(response):
        if request.path != '/metrics':
            latency = time.time() - request.start_time
            REQUEST_LATENCY.labels(request.method, request.path).observe(latency)
            REQUEST_COUNTER.labels(request.method, request.path, response.status_code).inc()
        return response

    @app.route('/api/comment/new', methods=['POST'])
    def add_comment():
        data = request.get_json()
        if not data or 'email' not in data or 'comment' not in data:
            return jsonify({'error': 'Missing required fields'}), 400

        new_comment = Comment(
            email=data['email'],
            comment=data['comment'],
            content_id=data['content_id']
        )
        
        db.session.add(new_comment)
        db.session.commit()
        
        return jsonify(new_comment.to_dict()), 201

    @app.route('/api/comment/list/<string:content_id>', methods=['GET'])
    def get_comments(content_id):
        comments = Comment.query.filter_by(content_id=content_id).all()
        if not comments:
            return jsonify({'message': 'No comments found for this content_id'}), 404
        
        return jsonify([comment.to_dict() for comment in comments]), 200

    @app.route('/health', methods=['GET'])
    def health_check():
        try:
            db.session.execute(text('SELECT 1'))
            return jsonify({'status': 'healthy'}), 200
        except Exception as e:
            return jsonify({'status': 'unhealthy', 'error': str(e)}), 503

    @app.route('/metrics', methods=['GET'])
    def metrics():
        return generate_latest(), 200
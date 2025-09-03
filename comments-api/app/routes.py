from flask import request, jsonify
from app import create_app, db
from app.models import Comment

app = create_app()

@app.route('/comments', methods=['POST'])
def add_comment():
    data = request.get_json()
    if not data or 'content' not in data or 'content_id' not in data:
        return jsonify({'error': 'Missing content or content_id'}), 400

    new_comment = Comment(
        content=data['content'],
        content_id=data['content_id']
    )
    
    db.session.add(new_comment)
    db.session.commit()
    
    return jsonify(new_comment.to_dict()), 201

@app.route('/comments/<string:content_id>', methods=['GET'])
def get_comments(content_id):
    comments = Comment.query.filter_by(content_id=content_id).all()
    if not comments:
        return jsonify({'message': 'No comments found for this content_id'}), 404
    
    return jsonify([comment.to_dict() for comment in comments]), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
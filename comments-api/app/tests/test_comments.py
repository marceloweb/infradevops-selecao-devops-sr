import pytest
from app import create_app, db
from app.models import Comment

@pytest.fixture
def app():
    test_config = {
        'TESTING': True,
        'SQLALCHEMY_DATABASE_URI': 'sqlite:///:memory:',
        'SQLALCHEMY_TRACK_MODIFICATIONS': False
    }
    app = create_app(test_config=test_config)
    with app.app_context():
        db.create_all()
        yield app
        db.session.remove()
        db.drop_all()

@pytest.fixture
def client(app):
    return app.test_client()

def test_add_comment(client):
    response = client.post('/api/comment/new', json={
        'email': 'test@example.com',
        'comment': 'This is a new test comment.',
        'content_id': '456'
    })
    
    assert response.status_code == 201
    assert b'test@example.com' in response.data

    comment = Comment.query.first()
    assert comment.email == 'test@example.com'
    assert comment.comment == 'This is a new test comment.'
    assert comment.content_id == '456'

def test_get_comments(client):
    comment1 = Comment(email='user1@test.com', comment='First comment', content_id='xyz')
    comment2 = Comment(email='user2@test.com', comment='Second comment', content_id='xyz')
    db.session.add(comment1)
    db.session.add(comment2)
    db.session.commit()
    
    response = client.get('/api/comment/list/xyz')
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) == 2
    assert data[0]['comment'] == 'First comment'
    assert data[1]['comment'] == 'Second comment'

def test_update_comment(client):
    comment_to_update = Comment(email='old@test.com', comment='Old content', content_id='123')
    db.session.add(comment_to_update)
    db.session.commit()

    response = client.put(f'/api/comment/update/{comment_to_update.id}', json={
        'comment': 'Updated content'
    })
    
    assert response.status_code == 200
    updated_comment = Comment.query.get(comment_to_update.id)
    assert updated_comment.comment == 'Updated content'

def test_delete_comment(client):
    comment_to_delete = Comment(email='delete@test.com', comment='Content to be deleted', content_id='999')
    db.session.add(comment_to_delete)
    db.session.commit()

    response = client.delete(f'/api/comment/delete/{comment_to_delete.id}')
    
    assert response.status_code == 200
    deleted_comment = Comment.query.get(comment_to_delete.id)
    assert deleted_comment is None
    assert b'Comment deleted successfully' in response.data

def test_health_check(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert response.get_json()['status'] == 'healthy'

def test_metrics(client):
    response = client.get('/metrics')
    assert response.status_code == 200
    assert b'http_requests_total' in response.data
    assert b'http_request_duration_seconds' in response.data
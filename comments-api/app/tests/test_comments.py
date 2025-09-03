import pytest
from app import create_app, db
from app.models import Comment

@pytest.fixture
def client():
    test_config = {
        'TESTING': True,
        'SQLALCHEMY_DATABASE_URI': 'sqlite:///:memory:',
        'SQLALCHEMY_TRACK_MODIFICATIONS': False
    }
    app = create_app(test_config=test_config)
    with app.app_context():
        db.create_all()
        yield app.test_client()
        db.session.remove()
        db.drop_all()

def test_add_comment(client):
    response = client.post('/comments', json={
        'content': 'This is a test comment.',
        'content_id': '123'
    })
    
    assert response.status_code == 201
    assert b'This is a test comment.' in response.data

    comment = Comment.query.first()
    assert comment.content == 'This is a test comment.'
    assert comment.content_id == '123'

def test_get_comments(client):
    comment1 = Comment(content='First comment', content_id='abc')
    comment2 = Comment(content='Second comment', content_id='abc')
    db.session.add(comment1)
    db.session.add(comment2)
    db.session.commit()
    
    response = client.get('/comments/abc')
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) == 2
    assert data[0]['content'] == 'First comment'
    assert data[1]['content'] == 'Second comment'

def test_get_comments_not_found(client):
    response = client.get('/comments/999')
    assert response.status_code == 404
    assert b'No comments found' in response.data
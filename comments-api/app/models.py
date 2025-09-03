from app import db
from datetime import datetime, timezone

class Comment(db.Model):
    __tablename__ = 'comments'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255), nullable=False)
    comment = db.Column(db.Text, nullable=False)
    content_id = db.Column(db.String(255), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.now(timezone.utc))

    def to_dict(self):
        return {
            'id': self.id,
            'email': self.email,
            'comment': self.comment,
            'content_id': self.content_id,
            'created_at': self.created_at.isoformat()
        }
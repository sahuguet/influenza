
from neo4j.v1 import GraphDatabase, basic_auth
from neo4j.v1.api import READ_ACCESS, WRITE_ACCESS

DB_URI_DEFAULT      = "bolt://localhost:7687"
DB_USER_DEFAULT     = 'neo4j'
DB_PASSWORD_DEFAULT = 'neo4j'

def driver(uri=DB_URI_DEFAULT, user=DB_USER_DEFAULT, password=DB_PASSWORD_DEFAULT):
    return GraphDatabase.driver(uri, auth=basic_auth(user, password))

def connect(db, mode=WRITE_ACCESS):
    return db.session(mode)

if __name__ == '__main__':

    # sample usage

    DB_PASSWORD = '__THIS_SPACE_LEFT_BLANK_INTENTIONALLY__'

    db = driver(password=DB_PASSWORD)
    session = connect(db, mode=READ_ACCESS)
    try:
        with session.begin_transaction() as tx:
            search_term = "Trump"
            result = session.run("""
                MATCH (person:Person)
                WHERE person.name CONTAINS {term}
                RETURN person.name
            """, { 'term': search_term })
            for record in result:
                print(record["person.name"])
            tx.success = True
    finally:
        session.close()


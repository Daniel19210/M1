from pymongo import MongoClient


def lectureListe(liste):
    for element in liste:
        print(f"{element=}")


client = MongoClient("mongodb://localhost:27017/")
db = client["SGD4"]
products = db["Products"]
categories = db["Categories"]
users = db["Users"]
review = db["Review"]
orders = db["Orders"]

listeProduit = [
    {
        "_id": "4c4b1476238d3b4dd5003981",
        "slug": "wheel-barrow-9092",
        "sku": "9092",
        "name": "Extra Large Wheel Barrow",
        "description": "Heavy duty wheel barrow...",
        "details": {
            "weight": 47,
            "weight_units": "lbs",
            "model_num": 4039283402,
            "manufacturer": "Acme",
            "color": "Green"
        },
        "total_reviews": 4,
        "average_review": 4.5,
        "pricing": {
            "retail": 5897,
            "sale": 4897
        },
        "price_history": [
            {
                "retail": 5297,
                "sale": 4297,
                "start": {"$date": "2010-05-01T00:00:00.000-0700"},
                "end": {"$date": "2010-05-08T00:00:00.000-0700"}
            },
            {
                "retail": 5297,
                "sale": 5297,
                "start": {"$date": "2010-05-09T00:00:00.000-0700"},
                "end": {"$date": "2010-05-16T00:00:00.000-0700"}
            }
        ],
        "category_ids": [
            "6a5b1476238d3b4dd5000048",
            "6a5b1476238d3b4dd5000049"
        ],
        "main_cat_id": "6a5b1476238d3b4dd5000048",
        "tags": ["tools", "gardening", "soil"]
    }
]
listeCategories = [
    {
        "_id": "6a5b1476238d3b4dd5000048",
        "slug": "gardening-tools",
        "ancestors": [
            {
                "name": "Home",
                "_id": "8b87fb1476238d3b4dd50003",
                "slug": "home"
            },
            {
                "name": "Outdoors",
                "_id": "9a9fb1476238d3b4dd500001",
                "slug": "outdoors"
            }
        ],
        "parent_id": "9a9fb1476238d3b4dd500001",
        "name": "Gardening Tools",
        "description": "Gardening gadgets galore!"
    }
]
listeUsers = [
    {

        "username": "kbanker",
        "email": "kylebanker@gmail.com",
        "first_name": "Kyle",
        "last_name": "Banker",
        "hashed_password": "bd1cfa194c3a603e7186780824b04419",
        "addresses": [
            {
                "name": "home",
                "street": "588 5th Street",
                "city": "Brooklyn",
                "state": "NY",
                "zip": 11215
            },
            {
                "name": "work",
                "street": "1 E. 23rd Street",
                "city": "New York",
                "state": "NY",
                "zip": 10010
            }
        ],
        "payment_methods": [
            {
                "name": "VISA",
                "last_four": 2127,
                "crypted_number": "43f6ba1dfda6b8106dc7",
                "expiration_date": {"$date": "2016-05-01T00:00:00.000-0700"}
            }
        ]
    }
]
listeReview = [
    {
        "_id": "4c4b1476238d3b4dd5000041",
        "product_id": "4c4b1476238d3b4dd5003981",
        "date": {"$date": "2010-06-07T00:00:00.000-0700"},
        "title": "Amazing",
        "text": "Has a squeaky wheel, but still a darn good wheel barrow.",
        "rating": 4,
        "user_id": "4c4b1476238d3b4dd5000001",
        "username": "dgreenthumb",
        "helpful_votes": 3,
        "voter_ids": [
            "4c4b1476238d3b4dd5000041",
            "7a4f0376238d3b4dd5000003",
            "92c21476238d3b4dd5000032"
        ]
    }
]
listeOrders = [
    {
        "_id": "6a5b1476238d3b4dd5000048",
        "user_id": "4c4b1476238d3b4dd5000001",
        "purchase_data": {"$date": "2014-08-01T00:00:00.000-0700"},
        "state": "CART",
        "line_items": [
            {
                "_id": "4c4b1476238d3b4dd5003981",
                "sku": "9092",
                "name": "Extra Large Wheel Barrow",
                "quantity": 1,
                "pricing": {
                    "retail": 5897,
                    "sale": 4897
                }
            },
            {
                "_id": "4c4b1476238d3b4dd5003982",
                "sku": "10027",
                "name": "Rubberized Work Glove, Black",
                "quantity": 1,
                "pricing": {
                    "retail": 1499,
                    "sale": 1299
                }
            }
        ],
        "shipping_address": {
            "street": "588 5th Street",
            "city": "Brooklyn",
            "state": "NY",
            "zip": 11215
        },
        "sub_total": 6196,
        "tax": 600
    }
]
# resProducts = products.insert_one(listeProduit)
# resCategories = categories.insert_one(listeCategories)
# resUsers = users.insert_one(listeUsers)
# resReview = review.insert_one(listeReview)
# resOrders = orders.insert_one(listeOrders)

# Nickel
# lectureListe(products.find({"category_ids": "6a5b1476238d3b4dd5000048"}))

# TypeError
product = products.find_one({"slug": "wheel-barrow-9092"})
# lectureListe(product)
lectureListe(categories.find({"_id": {"$in": product["category_ids"]}}))

# Est vide
# lectureListe(products.aggregate([{"$project": {"category_ids": 1}}, {"$unwind": "$category_id"}, {"$group": {"_id": "$category_id", "count": {"$sum":1}}}, {"$out":"countsByCategory"}]))

# Nickel
"""
lectureListe(users.aggregate([{'$lookup': {
    'from': 'reviews',
    'localField': '_id',
    'foreignField': 'users_id',
    'as': 'user_review'}}
]))
"""

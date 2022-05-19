-- file: BookStore.hs

data BookInfo = Book Int String [String]
                deriving (Show)

bookId (Book id _ _) = id



type CustomerId = Integer
type ReviewBody = String

data BookReview = BookReview BookInfo CustomerId ReviewBody



type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                 | CashOnDelivery
                 | Invoice CustomerId
                   deriving (Show)


data Roygbiv = Red
             | Orange
             | Yellow
             | Green
             | Blue
             | Indigo
             | Violet
               deriving (Eq, Show)

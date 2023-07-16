erDiagram %% some comments

hoge {
  bigint id PK 
  integer price
  string name 
  string remark 
}

fuga {
  bigint id PK
  integer hogeice
}

hoge_subscriptions ||--|| hoge

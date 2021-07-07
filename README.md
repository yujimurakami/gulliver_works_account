# 「Rails6 + REST API」
## 概要
Rails6（REST API）+ Docker + PostgreSQL + Auth機能（GulliverWorks用）
    
## 開発環境構築
### 環境構築する手順
1. .envファイルを作成
2. .env.sampleの中身を.envファイルにコピペする
3. `docker-compose up -d --build`コマンドを叩いて、完了

### Makefile
弊社ではMakefileを準備してあります。
頻出コマンドについては「make XXX」で実行できるようにしてあるので、Makefileを確認してみましょう。

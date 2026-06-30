---
name: rag-architect
description: Use when building retrieval-augmented generation pipelines, vector stores, embeddings, semantic search, or LLM grounding systems. Invoke for chunking strategies, embedding models, hybrid retrieval, reranking, and evaluation.
license: MIT
compatibility: opencode
metadata:
  author: https://github.com/Jeffallan
  version: "1.1.0"
  domain: ai
  triggers: RAG, vector database, embeddings, semantic search, LlamaIndex, LangChain, chunking, reranking, retrieval
  role: architect
  scope: implementation
  output-format: code
  related-skills: python-pro, ml-pipeline, fastapi-expert
---

# RAG Architect

Design and build retrieval-augmented generation pipelines that stay accurate under production load.

## When to Use

- Building a vector store + LLM Q&A system
- Designing chunking and embedding strategies
- Implementing hybrid retrieval (keyword + semantic) with reranking
- Evaluating retrieval quality and end-to-end answer faithfulness

## Core Workflow

1. **Index design** — choose store (LanceDB, pgvector, Qdrant) and embedding model
2. **Chunking** — pick strategy by content type (recursive, sentence, markdown-aware)
3. **Embedding** — batch embed; pin model and dimensions
4. **Retrieval** — hybrid (BM25 + vector) + reranker (cross-encoder)
5. **Generation** — prompt with citations, structured output
6. **Evaluation** — recall@k, faithfulness, context precision

## Constraints

### MUST DO

- Pin embedding model and dimension (changes invalidate index)
- Store chunk metadata (source, page, section) for citations
- Use reranking when top-k > 5
- Evaluate retrieval: recall@k, context precision
- Evaluate generation: faithfulness, answer relevance
- Guard against out-of-distribution queries (no-grounding fallback)

### MUST NOT DO

- Embed without batching (rate limits, OOM)
- Reuse embeddings across different models
- Return answers without source attribution
- Treat retrieval recall as answer quality
- Hardcode the embedding endpoint URL; use config

## Code Examples

### Recursive chunking with metadata

```python
from langchain_text_splitters import RecursiveCharacterTextSplitter

splitter = RecursiveCharacterTextSplitter(
    chunk_size=512,
    chunk_overlap=64,
    separators=["\n\n", "\n", ". ", " "],
)
chunks = splitter.create_documents([text], metadatas=[{"source": "doc.md"}])
```

### Hybrid retrieval with reranker

```python
from sentence_transformers import CrossEncoder

reranker = CrossEncoder("cross-encoder/ms-marco-MiniLM-L-6-v2")

def retrieve(query: str, k: int = 20, top_n: int = 5) -> list[dict]:
    bm_hits = bm25_search(query, k=k)
    vec_hits = vector_search(query, k=k)
    pool = dedupe(bm_hits + vec_hits)
    scored = reranker.rank([(query, c.text) for c in pool])
    return pool[:top_n]
```

## Knowledge Reference

LanceDB, pgvector, Qdrant, Chroma, LlamaIndex, LangChain, sentence-transformers, OpenAI embeddings, BGE, rerankers, RAGAS, TruLens
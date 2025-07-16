#!/usr/bin/env python3
"""
Script para corrigir todas as referências de tabelas antigas para novas
"""

import os
import re

def replace_in_file(filepath, replacements):
    """Substitui múltiplas strings em um arquivo"""
    try:
        with open(filepath, 'r', encoding='utf-8') as file:
            content = file.read()
        
        original_content = content
        for old, new in replacements.items():
            content = content.replace(old, new)
        
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as file:
                file.write(content)
            print(f"Atualizado: {filepath}")
        
    except Exception as e:
        print(f"Erro ao processar {filepath}: {e}")

def main():
    # Mapeamento das tabelas antigas para novas
    table_replacements = {
        ".from('profiles')": ".from('perfis')",
        ".from('dados_fisicos')": ".from('pesagens')",
        ".from('dados_saude')": ".from('dados_saude_usuario')",
    }
    
    # Processar todos os arquivos .tsx e .ts na pasta src
    for root, dirs, files in os.walk('src'):
        for file in files:
            if file.endswith(('.tsx', '.ts')):
                filepath = os.path.join(root, file)
                replace_in_file(filepath, table_replacements)

if __name__ == "__main__":
    main()
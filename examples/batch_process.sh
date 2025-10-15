#!/bin/bash
# Batch Process Text Files

set -e

# Create sample text files
mkdir -p input_texts
cat > input_texts/text1.txt << 'EOF'
This is the first test text. Welcome to use ChatTTS for speech synthesis.
EOF

cat > input_texts/text2.txt << 'EOF'
This is the second test text. It demonstrates how to batch process multiple files.
EOF

cat > input_texts/text3.txt << 'EOF'
This is the third test text. Batch processing can greatly improve work efficiency.
EOF

# Create output directory
mkdir -p output_audio

# Batch conversion
echo "Starting batch conversion..."
counter=0
for input_file in input_texts/*.txt; do
    filename=$(basename "$input_file" .txt)
    output_file="output_audio/${filename}.wav"
    
    echo "Processing: $input_file -> $output_file"
    chattts -f "$input_file" -o "$output_file"
    
    ((counter++))
done

echo
echo "Done! Processed $counter files"
echo "Output files:"
ls -lh output_audio/*.wav

# Cleanup (optional)
# rm -rf input_texts output_audio

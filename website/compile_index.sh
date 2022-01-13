JUPYTER_FOLDER=${1?Must provide first argument as output folder}
BASE_DOCUMENT=${2?Must base document to compile onto}
OUTPUT_PATH=${3}

# Add some styling to the document and a content div
echo "
<style>
body {
  background: #555;
}
.content {
  max-width: 500px;
  margin: auto;
  background: white;
  padding: 10px;
  min-height:100wh;
  border-radius: 10px;
}
</style>
" > index.md
echo '<div class="content">' >> index.md

# Compile out the markdown document
cat $BASE_DOCUMENT >> index.md

mkdir -p $JUPYTER_FOLDER
rm $JUPYTER_FOLDER/*.ipynb

mkdir -p $OUTPUT_PATH
rm $OUTPUT_PATH/*.html

cd $JUPYTER_FOLDER
wget "https://raw.githubusercontent.com/bjor2791/data-science-template/main/notebooks/E6_oslo_mogreina.ipynb"

cd ..

jupyter nbconvert --to html --output-dir $OUTPUT_PATH/ $JUPYTER_FOLDER/*.ipynb

echo -e "\n\n" >> index.md


for notebook in $OUTPUT_PATH/*.html

do
  echo "[$notebook](https://bjor2791.github.io/data-science-template/$notebook)" | tee -a index.md
  echo -e "\n" >> index.md
done

# Finally we end the document by adding the end of our content outline
echo "</div>" >> index.md
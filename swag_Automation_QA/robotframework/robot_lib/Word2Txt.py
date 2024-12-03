import docx2txt


class Word2Txt:

	def get_docx_content(self, path):
		content = docx2txt.process(path)
		return content

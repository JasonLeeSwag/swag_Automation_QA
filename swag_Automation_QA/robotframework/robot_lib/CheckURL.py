# -*- coding: utf8 -*-

import urllib.request


class CheckURL:

	def check_url_accessible(self, url):
		try:
			urllib.request.urlopen(url)
			return True
		except:
			return False

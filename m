From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 17 May 2021 09:11:36 -0700
Subject: [Intel-wired-lan] [PATCH v3 11/16] docs: networking:
 device_drivers: replace some characters
In-Reply-To: <23247f10ab58ae1b54ac368f8a2d2769562adcf4.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
 <23247f10ab58ae1b54ac368f8a2d2769562adcf4.1621159997.git.mchehab+huawei@kernel.org>
Message-ID: <20210517091136.00000e96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mauro Carvalho Chehab wrote:

> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
> 
> Replace the occurences of the following characters:
> 
> 	- U+00a0 ('?'): NO-BREAK SPACE
> 	  as it can cause lines being truncated on PDF output
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

For the Intel Ethernet Docs, LGTM!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

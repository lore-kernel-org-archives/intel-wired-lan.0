From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 15 Feb 2018 11:15:20 +0200
Subject: [Intel-wired-lan] How to install e1000e.ko to Debian 9
In-Reply-To: <45eb0080-4ad6-c88a-a2dd-a435c89bbd8c@actiu.net>
References: <45eb0080-4ad6-c88a-a2dd-a435c89bbd8c@actiu.net>
Message-ID: <0a21ad76-ec4f-5338-7cb9-afc854a6f2d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/15/2018 10:39, Narcis Garcia wrote:
> cc1: error: code model kernel does not support PIC mode
Hello,
I believe you have a two options: update your gcc compiler to 4.8 or try 
ad flag -fno-pie to your Makefile.
Please, refer to follow thread regard your question on source forge: 
https://sourceforge.net/p/e1000/bugs/542/
Also, I advice send your question to SourceForge mailing list: 
e1000-devel at lists.sourceforge.net.


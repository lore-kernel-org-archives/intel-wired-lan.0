From: Narcis Garcia <informatica@actiu.net>
Date: Thu, 15 Feb 2018 10:38:17 +0100
Subject: [Intel-wired-lan] How to install e1000e.ko to Debian 9
In-Reply-To: <0a21ad76-ec4f-5338-7cb9-afc854a6f2d3@intel.com>
Message-ID: <35e600ff-d3d7-232d-51e4-47428b9ab477@actiu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

$ gcc --version
gcc (Debian 6.3.0-18) 6.3.0 20170516

I'm not experienced with this.
How to flag -fno-pie to the "Makefile" ?

In the meanwhile, I'm doing the workaround by schnick:
Find in Makefile ( e1000e/src/Makefile , Line ~152) =>
EXTRA_CFLAGS += $(CFLAGS_EXTRA)
Insert a new line after that => EXTRA_CFLAGS += -fno-pie


El 15/02/18 a les 10:15, Neftin, Sasha ha escrit:
> On 2/15/2018 10:39, Narcis Garcia wrote:
>> cc1: error: code model kernel does not support PIC mode
> Hello,
> I believe you have a two options: update your gcc compiler to 4.8 or try
> ad flag -fno-pie to your Makefile.
> Please, refer to follow thread regard your question on source forge:
> https://sourceforge.net/p/e1000/bugs/542/
> Also, I advice send your question to SourceForge mailing list:
> e1000-devel at lists.sourceforge.net.
> 

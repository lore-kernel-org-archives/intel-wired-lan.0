From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 13 Sep 2016 18:28:03 +0000
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] e1000: add
	initial	XDP support
In-Reply-To: <20160913175926.GA38737@ast-mbp.thefacebook.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221351.5610.29043.stgit@john-Precision-Tower-5810>
 <1473720399.18970.91.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160912230745.GA24171@ast-mbp.thefacebook.com>
 <1473723968.18970.111.camel@edumazet-glaptop3.roam.corp.google.com>
 <CALx6S35CE+ZYbGm96Y5YKnTqU0zfhg9_h0VSpD3ot8xB-scdFQ@mail.gmail.com>
 <20160913012815.GB25756@ast-mbp.thefacebook.com>
 <CALx6S36u+tQUEVhu0BaLZ6-_0=GSMwxd4m89-H+brVZ-rr-U2g@mail.gmail.com>
 <20160913171340.GA37341@ast-mbp.thefacebook.com>
 <1473788252.18970.177.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160913175926.GA38737@ast-mbp.thefacebook.com>
Message-ID: <36ECC79A-0810-4D06-A72D-702AD9901E83@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> I've looked through qemu and it appears only emulate e1k and tg3.
> The latter is still used in the field, so the risk of touching
> it is higher.

I have no idea what makes you think that e1k is *not* "used in the field".   
I grant you it probably is used more virtualized than not these days, but  
it certainly exists and is used. You can still buy them new at Newegg for  
goodness sakes!

Maybe I'll go home and plug in my old e100 into my machine that still has a  
PCI slot, just for old times sake. Oh darn, I have a SCSI card in that  
slot...

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160913/c759115f/attachment.asc>

From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 16 Sep 2015 23:36:41 +0000
Subject: [Intel-wired-lan] [next-queue 1/8] e1000: clean up the useless
 'continue' statement
In-Reply-To: <55F9DA6E.8090300@gmail.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
 <1442212070-24937-2-git-send-email-sakiwit@gmail.com>
 <32D3D43C-B677-4C70-8915-3B07B1175C66@intel.com>
 <20150915053501.GA3881@mail.gmail.com>
 <9EC98ADF-EA6D-4BDC-A442-F42BB805FA84@intel.com>
 <20150916153428.GB3881@mail.gmail.com> <55F99B1B.1010504@gmail.com>
 <F274D7F1-7F0F-4C42-95BB-47E22E9DB386@intel.com> <55F9DA6E.8090300@gmail.com>
Message-ID: <2E5E7AEC-E02A-42F4-96D6-CF0C35B94B96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Sep 16, 2015, at 2:09 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> I have a very strong suspicion that the 0xFF value is an error, but I don't see the documentation for the ce4100 anywhere to be had on where they came up with that value.  If it is supposed to be the result of a register read failure I believe the result would already be 0 since there is a flag in the register that indicates a read status failue and if it is set the value isn't stored.

I think that it is likely that Alex is right, but the code cleanup should be separated from a functional change in any case, so for this patch, please leave it as 0xFF for now. I have asked someone more familiar with it to look further. Thanks.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150916/a1c6c6c8/attachment.asc>

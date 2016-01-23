From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Sat, 23 Jan 2016 01:54:55 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix flow control for BDX-DE
	KR	backplane
In-Reply-To: <20160123014235.49376.51296.stgit@mdrustad-wks.jf.intel.com>
References: <20160123014235.49376.51296.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <050F5CB8-04CE-468E-9B3F-1C039D554020@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mark D Rustad <mark.d.rustad@intel.com> wrote:

> BDX-DE KR backplane is different from other backplanes,
> in that we can't use auto-negotiation to determine the
> mode. Instead, use whatever the user configured.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Sorry. Please drop this patch. It does't really handle all devices quite  
right.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160123/4348f4db/attachment-0001.asc>

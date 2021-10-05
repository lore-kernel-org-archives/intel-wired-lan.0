From: Andreas K. Huettel <andreas.huettel@ur.de>
Date: Tue, 05 Oct 2021 02:12:07 +0200
Subject: [Intel-wired-lan] [EXT] Re: Intel I350 regression 5.10 -> 5.14
 ("The NVM Checksum Is Not Valid") [8086:1521]
In-Reply-To: <7064659e-fe97-f222-5176-844569fb5281@twofifty.com>
References: <1823864.tdWV9SEqCh@kailua>
 <20211004074814.5900791a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7064659e-fe97-f222-5176-844569fb5281@twofifty.com>
Message-ID: <1763660.QCnGb9OGeP@pinacolada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> >> 
> >> Any advice on how to proceed? Willing to test patches and provide
> >> additional debug info.
> Sorry to reply from a non-Intel account. I would suggest first
> contacting Dell, and then contacting DeLock. This sounds like an
> issue with motherboard firmware and most of what I can help with
> would be with the driver. I think the issues are probably before
> things get to the driver.

Ouch. OK. Can you think of any temporary workaround?

(Other than downgrading to 5.10 again, which I can't since it fails
at the graphics (i915) modesetting...)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 981 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211005/c7c9b8f3/attachment.asc>

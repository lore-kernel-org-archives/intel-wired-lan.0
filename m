From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 04 Jun 2015 05:37:19 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: Fix missing braces after if
	statement
In-Reply-To: <20150603.235751.1703498220892447151.davem@davemloft.net>
References: <20150604015219.2895.80478.stgit@ahduyck-vm-fedora22>
 <20150603.235751.1703498220892447151.davem@davemloft.net>
Message-ID: <1433421439.12224.0.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-06-03 at 23:57 -0700, David Miller wrote:
> From: Alexander Duyck <alexander.h.duyck@redhat.com>
> Date: Wed, 03 Jun 2015 18:53:17 -0700
> 
> > While reviewing the code I noticed that one of the commits added an if
> > statement followed by a for loop, but the if statement was missing the
> > braces around the loop.  This change corrects the coding style error.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> 
> I assume that I will get this via Jeff.

Yeah, I have this queued up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150604/b60d8f17/attachment.asc>

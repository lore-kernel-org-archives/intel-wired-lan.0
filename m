From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 22 Aug 2016 16:13:32 -0700
Subject: [Intel-wired-lan] [dev-queue PATCH v2 2/3] i40e: Enable VF
 specific ethtool statistics via VF Port representor netdevs.
In-Reply-To: <57BB2980.50902@intel.com>
References: <1471542901-13405-1-git-send-email-sridhar.samudrala@intel.com>
 <1471542901-13405-3-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UfsO=FGZAnHmXCHsrVXjtfK=G7ebNREw7nnX_KFP-Xi5g@mail.gmail.com>
 <57BB2980.50902@intel.com>
Message-ID: <1471907612.2325.27.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-08-22 at 09:34 -0700, Samudrala, Sridhar wrote:
> > So one change you need to this is to swap the rx_ and tx_ portion of
> > the strings.? You have to keep in mind this is a switch port
> > representation so the Rx and Tx values are swapped.? Every byte the VF
> > receives is actually a byte that we transmitted to the VF.
> >
> > You could probably also add a comment above this block stating that
> > the two were swapped and why.
> >
> Yes. As we are saying that this netdev represents the switch port?
> corresponding to the VF, it makes
> sense to swap the rx and tx stats.
> 
> Jeff,
> Should i submit a patch on top of this patchset as it is already in?
> dev-queue branch?
> Or resubmit the patchset as a v3 with this update.

Alex is correct, please re-submit the series with the desired changes to
this and any other patches, please. ?I can drop this series from my tree if
that helps you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160822/788f622d/attachment-0001.asc>

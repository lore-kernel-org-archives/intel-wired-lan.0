From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 04 Jun 2018 11:18:22 -0700
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Move ipsec init
 function to before reset call
In-Reply-To: <CAKgT0UcO3uZXZuSu2n51M9ac6VEFNgnZsds=yOTAhdstVQG0hQ@mail.gmail.com>
References: <20180604162312.79628.37984.stgit@ahduyck-green-test.jf.intel.com>
 <4b8f422b-b694-6729-709d-647d44148e7c@oracle.com>
 <CAKgT0Ue6C38xpHpT42o0A0yhpcR-z03k4fPo_Ts9UiMWtWyKsg@mail.gmail.com>
 <CAKgT0UcO3uZXZuSu2n51M9ac6VEFNgnZsds=yOTAhdstVQG0hQ@mail.gmail.com>
Message-ID: <27f3c935574c687381b7c8a57b8dc0323519a349.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-06-04 at 11:14 -0700, Alexander Duyck wrote:
> On Mon, Jun 4, 2018 at 11:07 AM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Mon, Jun 4, 2018 at 10:34 AM, Shannon Nelson
> > <shannon.nelson@oracle.com> wrote:
> > > On 6/4/2018 9:24 AM, Alexander Duyck wrote:
> > > > 
> > > > This patch moves the ipsec init function in ixgbe_sw_init. This
> > > > way it is
> > > > a
> > > > bit more consistent with the placement of similar
> > > > initialization functions
> > > > and is placed before the reset_hw call which should allow us to
> > > > clean up
> > > > any link issues that may be introduced by the fact that we
> > > > force the link
> > > > up if somehow the device had ipsec still enabled before the
> > > > driver was
> > > > loaded.
> > > > 
> > > > Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop
> > > > routines")
> > > > Reported-by: Andre Tomt <andre@tomt.net>
> > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > > > ---
> > > 
> > > 
> > > NAK - this won't work for the simple reason that the netdev
> > > feature flags
> > > that ixgbe_init_ipsec_offload() sets will get bashed later when
> > > probe()
> > > starts setting netdev feature flags.
> > 
> > Yeah, I realized that after I started doing any testing. I was
> > already
> > working on a v2 to address that as we could pull the feature bit
> > setting out and place it with the other features and only enable it
> > based on if adapter->ipsec is set or not.
> 
> Jeff,
> 
> Please drop this patch. I will work with Shannon to make sure we have
> a more complete solution.

Already done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180604/04c06486/attachment.asc>

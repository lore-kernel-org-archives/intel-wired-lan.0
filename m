From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 19 Sep 2018 15:23:25 -0700
Subject: [Intel-wired-lan] [PATCH v3] i40e: Introduce recovery mode
 support
In-Reply-To: <36aa7d93-5d45-0782-d61f-e12bb0238c41@oracle.com>
References: <20180919203459.17064-1-jeffrey.t.kirsher@intel.com>
 <36aa7d93-5d45-0782-d61f-e12bb0238c41@oracle.com>
Message-ID: <070c67a60ae49e5e05196653f3f477de018c78e6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-09-19 at 14:50 -0700, Shannon Nelson wrote:
> On 9/19/2018 1:34 PM, Jeff Kirsher wrote:
> > From: Alice Michael <alice.michael@intel.com>
> > 
> > This patch introduces "recovery mode" to the i40e driver. It is
> > part of a new Any2Any idea of upgrading the firmware. In this
> > approach, it is required for the driver to have support for
> > "transition firmware", that is used for migrating from structured
> > to flat firmware image. In this new, very basic mode, i40e driver
> > must be able to handle particular IOCTL calls from the NVM Update
> > Tool and run a small set of AQ commands.
> > 
> > Signed-off-by: Alice Michael <alice.michael@intel.com>
> > ---
> > v2: combined all the patches in Series 94 into one patch since all
> > of
> > the patches in the series were either introducing the recovery mode
> > support or were fixing the recovery mode.  Thanks to  Shannon
> > Nelson
> > for pointing this out.
> > Also fixed where we forgot to set vsi->netdev to NULL after calling
> > free_netdev().
> > 
> > v3: Fixed up code comments and style based on feedback from Shannon
> 
> I see that my thoughts on the comments got addressed, but I see no 
> response to most of the code suggestions.  Yes, this patch will
> work, 
> but I think it could be better.

Both Mitch and I reviewed your other code suggestions and currently we
did not have enough information to 'safely' make the other suggested
changes.  We currently have validated the current code extensively, to
ensure that the existing code produces the expected results.

I will be taking your suggested changes and do further research/testing
before possibly doing a follow on patch to implement your suggestions.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180919/e7ca2835/attachment.asc>

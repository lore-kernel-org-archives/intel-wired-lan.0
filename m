From: Josh Hunt <joshhunt00@gmail.com>
Date: Fri, 18 Oct 2019 11:04:06 -0700
Subject: [Intel-wired-lan] [PATCH v3 2/3] ixgbe: Add UDP segmentation
 offload support
In-Reply-To: <a99acf6128404c54ba837e2b0afe1d98@intel.com>
References: <1570812820-20052-1-git-send-email-johunt@akamai.com>
 <1570812820-20052-3-git-send-email-johunt@akamai.com>
 <a99acf6128404c54ba837e2b0afe1d98@intel.com>
Message-ID: <CAKA=qzZcO9vuJeuBhXd+25WHuMVHz1LbyCBngqhd0mQ3a0LF0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 17, 2019 at 5:33 AM Bowers, AndrewX
<andrewx.bowers@intel.com> wrote:
>
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Josh Hunt
> > Sent: Friday, October 11, 2019 9:54 AM
> > To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> > Jeffrey T <jeffrey.t.kirsher@intel.com>
> > Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>;
> > willemb at google.com; Josh Hunt <johunt@akamai.com>;
> > alexander.h.duyck at linux.intel.com
> > Subject: [Intel-wired-lan] [PATCH v3 2/3] ixgbe: Add UDP segmentation
> > offload support
> >
> > Repost from a series by Alexander Duyck to add UDP segmentation offload
> > support to the igb driver:
> > https://lore.kernel.org/netdev/20180504003916.4769.66271.stgit at localhost.l
> > ocaldomain/
> >
> > CC: Alexander Duyck <alexander.h.duyck@intel.com>
> > CC: Willem de Bruijn <willemb@google.com>
> > Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > Signed-off-by: Josh Hunt <johunt@akamai.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 24
> > ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
>
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
>
>
Andrew, thanks for testing. Were you able to validate the igb driver?

Thanks
-- 
Josh

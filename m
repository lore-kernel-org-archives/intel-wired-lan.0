From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 31 Mar 2016 15:04:38 -0700
Subject: [Intel-wired-lan] [net PATCH v2] i40e/i40evf: Limit TSO to 7
 descriptors for payload instead of 8 per packet
In-Reply-To: <20160330231116.12643.59554.stgit@localhost.localdomain>
References: <20160330231116.12643.59554.stgit@localhost.localdomain>
Message-ID: <20160331150438.00005617@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 30 Mar 2016 16:15:37 -0700
Alexander Duyck <aduyck@mirantis.com> wrote:

> This patch addresses a bug introduced based on my interpretation of the
> XL710 datasheet.  Specifically section 8.4.1 states that "A single transmit
> packet may span up to 8 buffers (up to 8 data descriptors per packet
> including both the header and payload buffers)."  It then later goes on to
> say that each segment for a TSO obeys the previous rule, however it then
> refers to TSO header and the segment payload buffers.
> 
> I believe the actual limit for fragments with TSO and a skbuff that has
> payload data in the header portion of the buffer is actually only 7
> fragments as the skb->data portion counts as 2 buffers, one for the TSO
> header, and one for a segment payload buffer.
> 
> Fixes: 2d37490b82af ("i40e/i40evf: Rewrite logic for 8 descriptor per packet check")
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> 
> v2: I realized that I overlooked the check in the inline function and as a
>     result we were still allowing for cases where 8 descriptors were being
>     used per packet and this would result in 9 DMA buffers.  I updated the
>     code so that we only allow 8 in the case of a single send, otherwise we
>     go into the function that walks the frags to verify each block.
> 
> I have tested this using rds-stress and it seems to run traffic without
> throwing any errors.

Looking like it is working for me too with at least the PF.

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Should also add:
Reported-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

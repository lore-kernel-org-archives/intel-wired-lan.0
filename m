From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 12 Jan 2016 04:15:44 -0800
Subject: [Intel-wired-lan] [next PATCH S27 00/15] i40e/i40evf updates
In-Reply-To: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452600944.3643.35.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-01-11 at 15:18 -0800, Joshua Hay wrote:
> Anjali Singhai Jain refactors force_wb and WB_ON_ITR functionality
> code.
> 
> Catherine Sullivan changes vf driver string to reflect all products?
> i40evf supports.
> 
> Jesse Brandeburg moves sync_vsi_filters up in service task, doesn't
> lose?
> interrupts, tries again after failure, dumps descriptor indexes in
> hex,
> uses __GFP_NOWARN, bumps version.
> 
> Mitch Williams uses pages correctly in rx, uses logical operators,?
> not bitwise, properly shows packet split status in debugfs.
> 
> Neerav Parikh makes the DCB firmware checks for X710/XL710 only.
> 
> Shannon Nelson sets shared bit for multicast filters, adds VEB stat
> control and removes L2 cloud filter, uses new add_veb calling with?
> veb stats control.
> 
> ?drivers/net/ethernet/intel/i40e/i40e.h???????????? |? 23 +-
> ?drivers/net/ethernet/intel/i40e/i40e_common.c????? |? 21 +-
> ?drivers/net/ethernet/intel/i40e/i40e_debugfs.c???? |? 25 +-
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c???? |? 11 +-
> ?drivers/net/ethernet/intel/i40e/i40e_main.c??????? |? 51 +++--
> ?drivers/net/ethernet/intel/i40e/i40e_prototype.h?? |?? 6 +-
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.c??????? | 249
> +++++++++++++-------
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.h??????? |?? 9 +-
> ?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |?? 4 +-
> ?drivers/net/ethernet/intel/i40evf/i40e_txrx.c????? | 253
> ++++++++++++++-------
> ?drivers/net/ethernet/intel/i40evf/i40e_txrx.h????? |? 10 +-
> ?drivers/net/ethernet/intel/i40evf/i40evf_main.c??? |?? 6 +-
> ?12 files changed, 445 insertions(+), 223 deletions(-)

Dropping this series because the second patch did not apply cleanly AND
after applying patch 2 by hand, patches 3 & 4 generated compile
warnings and errors.

Rather than taking the time to cleanup your patches, simply dropping
them and will wait for you to rebase your patches against my current
tree and re-submit.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160112/8d891ec5/attachment.asc>

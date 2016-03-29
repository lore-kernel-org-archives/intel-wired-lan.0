From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 28 Mar 2016 21:31:13 -0700
Subject: [Intel-wired-lan] [next PATCH S32 00/14] i40e/i40evf updates
In-Reply-To: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459225873.2953.60.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-03-28 at 04:17 -0700, Harshitha Ramamurthy wrote:
> Akeem G Abodunrin moves the HW flush to avoid problems in
> pass-through routines.?
> 
> Anjali Singhai Jain adds a hook to support trusted VF.
> 
> Deepthi Kavalur adds capability to display HW information.
> 
> Harshitha Ramamurthy bumps i40e/i40evf from 1.5.2 to 1.5.5.
> 
> Jesse Brandeburg moves a stack variable deeper, drops unused?
> tx_ring arguments and makes RX faster via avoiding FCOE.
> 
> Kiran Patil defines input set mask constants for RSS,
> flow director,flex bytes and renames defines for the input set
> mask.
> 
> Mitch Williams adds RSS configuration to the virtual channel.
> 
> Shannon Nelson ensures device capabilities do not get printed?
> when not needed, adds code to restrict VF poll mode to only?
> single function mode devices, moves NVM variable out of AQ?
> struct and moves nvm event wait check to nvm code.
> 

I am dropping this whole series for the following reasons:

patch 7 does not compile at all
patch 10 does not apply
you request that patch 13 be dropped from the series

Please resolve the three issues above and resubmit v2 please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160328/4be1117c/attachment.asc>

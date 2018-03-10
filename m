From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sat, 10 Mar 2018 08:39:04 -0800
Subject: [Intel-wired-lan] [PATCH 09/15] ice: Configure VSIs for Tx/Rx
In-Reply-To: <20180309172136.9073-10-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-10-anirudh.venkataramanan@intel.com>
Message-ID: <20180310083904.409d63f6@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri,  9 Mar 2018 09:21:30 -0800
Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> wrote:

> This patch configures the VSIs to be able to send and receive
> packets by doing the following:
> 
> 1) Initialize flexible parser to extract and include certain
>    fields in the Rx descriptor.
> 
> 2) Add Tx queues by programming the Tx queue context (implemented in
>    ice_vsi_cfg_txqs). Note that adding the queues also enables (starts)
>    the queues.
> 
> 3) Add Rx queues by programming Rx queue context (implemented in
>    ice_vsi_cfg_rxqs). Note that this only adds queues but doesn't start
>    them. The rings will be started by calling ice_vsi_start_rx_rings on
>    interface up.
> 
> 4) Configure interrupts for VSI queues.
> 
> 5) Implement ice_open and ice_stop.
> 
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Mandatory Vonnegut reference
Is ice9 deadly?

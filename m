From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:21:09 +0000
Subject: [Intel-wired-lan] [PATCH v3 15/16] fm10k: use the MAC/VLAN
 queue	for VF<->PF MAC/VLAN requests
In-Reply-To: <20170710202319.22110-15-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-15-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF67BD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Monday, July 10, 2017 1:23 PM
> To: jtkirhse at osuosl.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: jekeller at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 15/16] fm10k: use the MAC/VLAN queue
> for VF<->PF MAC/VLAN requests
> 
> Now that we have a working MAC/VLAN queue for handling MAC/VLAN
> messages
> from the netdev, replace the default handler for the VF<->PF messages.
> This new handler is very similar to the default code, but uses the
> MAC/VLAN queue instead of sending the message directly. Unfortunately we
> can't easily re-use the default code, so we'll just replace the entire
> function.
> 
> This ensures that a VF requesting a large number of VLANs or MAC
> addresses does not start a reset cycle, as explained in the commit which
> introduced the message queue.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>


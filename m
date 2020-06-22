From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 22 Jun 2020 14:45:46 -0700
Subject: [Intel-wired-lan] [PATCH net-next 3/3] i40e: introduce new dump
 desc xdp command
In-Reply-To: <20200622124624.18847-3-ciara.loftus@intel.com>
References: <20200622124624.18847-1-ciara.loftus@intel.com>
 <20200622124624.18847-3-ciara.loftus@intel.com>
Message-ID: <20200622144546.04da25d6@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Jun 2020 12:46:24 +0000 Ciara Loftus wrote:
> Interfaces already exist for dumping rx and tx descriptor information.
> Introduce another for doing the same for xdp descriptors.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Please make sure things build cleanly with W=1 C=1

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:543: warning: Function parameter or member 'type' not described in 'i40e_dbg_dump_desc'
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:543: warning: Excess function parameter 'ring_type' description in 'i40e_dbg_dump_desc'

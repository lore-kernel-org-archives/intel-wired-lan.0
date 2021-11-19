From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 19 Nov 2021 18:22:30 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix NULL pointer
 dereference in i40e_dbg_dump_desc
In-Reply-To: <20211117101737.8961-1-mateusz.palczewski@intel.com>
References: <20211117101737.8961-1-mateusz.palczewski@intel.com>
Message-ID: <491af7df6c21a21148316723ab4b720e7bbdcd90.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-11-17 at 11:17 +0100, Mateusz Palczewski wrote:
> From: Norbert Zulinski <norbertx.zulinski@intel.com>
> 
> When trying to dump VFs VSI RX/TX descriptors
> using debugfs there was a crash
> due to NULL pointer dereference in i40e_dbg_dump_desc.
> Added a check to i40e_dbg_dump_desc that checks if
> VSI type is correct for dumping RX/TX descriptors.
> 
> Fixes: 02e9c290814c ("i40e: debugfs interface")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>

There is no Signed-off-by from the author.

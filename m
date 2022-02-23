From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 22 Feb 2022 17:47:04 -0800
Subject: [Intel-wired-lan] [net-next PATCH 23/25] ice: cleanup long
 longs in ice_sriov.c
In-Reply-To: <20220223002712.2771809-24-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-24-jacob.e.keller@intel.com>
Message-ID: <bcba92ad-d159-2abc-f7d1-92043c9c44bc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Subject should be "cleanup long lines" not "cleanup long longs"


On 2/22/2022 4:27 PM, Jacob Keller wrote:
> Before we move the virtchnl message handling from ice_sriov.c into
> ice_virtchnl.c, cleanup some long line warnings to avoid checkpatch.pl
> complaints.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>



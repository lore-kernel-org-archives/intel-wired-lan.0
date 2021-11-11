From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 11 Nov 2021 08:50:01 -0800
Subject: [Intel-wired-lan] [PATCH linux] e1000e: Delete redundant
 variable definitions
In-Reply-To: <202111112246.M0trEfiC-lkp@intel.com>
References: <20211111090555.158828-1-luo.penghao@zte.com.cn>
 <202111112246.M0trEfiC-lkp@intel.com>
Message-ID: <20211111085001.24b58b5c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 11 Nov 2021 22:56:38 +0800 kernel test robot wrote:
> >> drivers/net/ethernet/intel/e1000e/e1000.h:31:20: error: 'hw' undeclared (first use in this function)  
>       31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)

Yeah, the infinite wisdom of Intel drivers using macros with implicit
arguments :/

You should build test your patches, tho.

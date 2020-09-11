From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 11 Sep 2020 15:16:01 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/11] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200911143405.00004085@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911075515.6d81066b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200911120005.00000178@intel.com>
 <20200911131238.1069129c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200911143405.00004085@intel.com>
Message-ID: <20200911151601.3207ed80@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 11 Sep 2020 14:34:05 -0700 Jesse Brandeburg wrote:
> If I'm not mistaken *all* the warnings you had listed are from C=1
> (sparse) which would be best fixed with a second set of patches. This
> set of patches only aimed to get rid of the W=1 (gcc warnings and kdoc
> warnings from scripts/kernel-doc)

Oh damn, you're right. I got fooled by my own logs :/

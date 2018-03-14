From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Wed, 14 Mar 2018 10:30:02 +0900
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180313141414.00007d11@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
 <1520967916.696.21.camel@intel.com>
 <a6f3bd20-705e-2022-23c8-1e3b5a8c93a6@gmail.com>
 <20180313141414.00007d11@intel.com>
Message-ID: <1d13d4bd-f8fa-cfd6-719f-bcfa52371ad1@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/03/14 6:14, Jesse Brandeburg wrote:
> which iproute2 tool shows the /proc/net/dev stats?

ip -s -s link show

-- 
Toshiaki Makita


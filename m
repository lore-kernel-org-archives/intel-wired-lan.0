From: David Miller <davem@davemloft.net>
Date: Tue, 09 Feb 2016 17:10:48 -0500 (EST)
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob
In-Reply-To: <CAP-MU4Mr5SkpC9XZuPa5xaAjgJ+_j3Gt5hYcSO6a2Q7jVB8HcQ@mail.gmail.com>
References: <1455015744.3592.46.camel@intel.com>
 <20160209115921.GE18781@lunn.ch>
 <CAP-MU4Mr5SkpC9XZuPa5xaAjgJ+_j3Gt5hYcSO6a2Q7jVB8HcQ@mail.gmail.com>
Message-ID: <20160209.171048.159766540065134460.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>
Date: Tue, 9 Feb 2016 09:42:45 -0800

> It seem to me this should be using eth_platform_get_mac_address(), a
> slightly more generic method to do this.  See the i40e driver for an
> example, commit d9a84324e6 I believe.

+1

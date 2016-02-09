From: Shannon Nelson <shannon.nelson@intel.com>
Date: Tue, 9 Feb 2016 09:42:45 -0800
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob
In-Reply-To: <20160209115921.GE18781@lunn.ch>
References: <56ABE3A8.4010602@gmail.com> <1455015744.3592.46.camel@intel.com>
 <20160209115921.GE18781@lunn.ch>
Message-ID: <CAP-MU4Mr5SkpC9XZuPa5xaAjgJ+_j3Gt5hYcSO6a2Q7jVB8HcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It seem to me this should be using eth_platform_get_mac_address(), a
slightly more generic method to do this.  See the i40e driver for an
example, commit d9a84324e6 I believe.

sln

On Tue, Feb 9, 2016 at 3:59 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +       dn = of_find_compatible_node(NULL, NULL, "intel,i211");
>
> Humm, NULL, NULL. That means find the first node anywhere in the
> device tree which matches. This is not going to work too well when you
> have multiple i211s.
>
> There is a way so specify a DT node is attached to a specific PCIe
> bus/slot. I think you should search only there, so solving the
> multiple device issue.
>
>          Andrew



-- 
==============================================

Mr. Shannon Nelson                        Network Division, Intel Corp.

Shannon.Nelson at intel.com                I don't speak for Intel

                 Parents can't afford to be squeamish

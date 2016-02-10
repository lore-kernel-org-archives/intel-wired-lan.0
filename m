From: John Holland <jotihojr@gmail.com>
Date: Wed, 10 Feb 2016 09:50:50 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
	using a device tree blob
In-Reply-To: <CAP-MU4Mr5SkpC9XZuPa5xaAjgJ+_j3Gt5hYcSO6a2Q7jVB8HcQ@mail.gmail.com>
References: <56ABE3A8.4010602@gmail.com> <1455015744.3592.46.camel@intel.com>
 <20160209115921.GE18781@lunn.ch>
 <CAP-MU4Mr5SkpC9XZuPa5xaAjgJ+_j3Gt5hYcSO6a2Q7jVB8HcQ@mail.gmail.com>
Message-ID: <0D415283-34B1-498E-9783-51BACD961963@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> On Feb 9, 2016, at 18:42, Shannon Nelson <shannon.nelson@intel.com> wrote:
> 
> It seem to me this should be using eth_platform_get_mac_address(), a
> slightly more generic method to do this.  See the i40e driver for an
> example, commit d9a84324e6 I believe.
> 
I believe you are referring to https://patchwork.ozlabs.org/patch/566806. Haven't seen this used upstream yet. And, does that not mandate CONFIG_OF?

John

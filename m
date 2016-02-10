From: John Holland <jotihojr@gmail.com>
Date: Wed, 10 Feb 2016 10:16:27 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
	using a device tree blob
In-Reply-To: <20160209115921.GE18781@lunn.ch>
References: <56ABE3A8.4010602@gmail.com> <1455015744.3592.46.camel@intel.com>
 <20160209115921.GE18781@lunn.ch>
Message-ID: <DF83416F-314C-4F27-A649-DD6574A83AE7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Feb 9, 2016, at 12:59, Andrew Lunn <andrew@lunn.ch> wrote:

>>> +       dn = of_find_compatible_node(NULL, NULL, "intel,i211");
> 
> Humm, NULL, NULL. That means find the first node anywhere in the
> device tree which matches. This is not going to work too well when you
> have multiple i211s.
> 
> There is a way so specify a DT node is attached to a specific PCIe
> bus/slot. I think you should search only there, so solving the
> multiple device issue.
> 

Good point. Will specify the current PCIe node.

From: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Date: Tue, 21 May 2019 17:42:37 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Work around hardware unit
 hang by disabling TSO
In-Reply-To: <d308eb17-98ab-13e7-6c74-d701288e43b5@intel.com>
References: <1623942.pXzBnfQ100@rocinante.m.i2n>
 <d308eb17-98ab-13e7-6c74-d701288e43b5@intel.com>
Message-ID: <3878056.TXPIU5uV5l@rocinante.m.i2n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Sasha,

On Wednesday, 15 May 2019 07:39:46 CEST Neftin, Sasha wrote:
> You are right, in some particular configurations e1000e devices stuck at
> Tx hang while TCP segmentation offload is on. But for all other users we
> should keep the TCP segmentation option is enabled as default. I suggest
> to use 'ethtool' command: ethtool -K <adapter> tso on/off to workaround
> Tx hang in your situation.
> Thanks,
> Sasha

thank you for your reply.

I did consider using "ethtool" to disable TSO for my use cases. However, I 
have no guarantees that a machine with the PCH2 device will not hang and 
render my system inaccessible before anything in userspace runs. No amount of 
connection outage is acceptable.

The problem escalates when we take into consideration that the exact 
circumstances that bring the device into an unrecoverable state don't seem to 
be known even by the Intel developers themselves.

This patch keeps the problematic device stable for all configurations.

So I ask myself, how actually feasible is it to gamble the usage of "ethtool" 
to turn on or off TSO every time the network configuration changes?

Why should we let the users run into an open knife instead of preemptively fix 
a known hardware bug via the kernel? Otherwise all Linux distributions would 
need to apply the magic ethtool fix for this specific PCI id.

Best regards,
Juliana



From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 22 May 2019 13:58:54 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Work around hardware unit
 hang by disabling TSO
In-Reply-To: <3878056.TXPIU5uV5l@rocinante.m.i2n>
References: <1623942.pXzBnfQ100@rocinante.m.i2n>
 <d308eb17-98ab-13e7-6c74-d701288e43b5@intel.com>
 <3878056.TXPIU5uV5l@rocinante.m.i2n>
Message-ID: <56e233f9-0a50-56f4-c256-38909cfa165b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/21/2019 18:42, Juliana Rodrigueiro wrote:
> So I ask myself, how actually feasible is it to gamble the usage of "ethtool"
> to turn on or off TSO every time the network configuration changes?
Hello Juliana,
There are many PCH2 devices with different SKU's.  Not all devices have 
this problem (Tx hand). We do not want to set disabling TSO as the 
default version. Let's keep this option for all other users.
Also, this is very old known HW bug - unfortunately we didn't fixed it. 
Our more new devices have not this problem.

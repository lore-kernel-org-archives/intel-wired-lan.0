From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 8 Oct 2020 10:51:52 -0700
Subject: [Intel-wired-lan] What are management packets (rx_smbus,
 MGTPRC)?
In-Reply-To: <8ecde631-9b24-b177-749c-a5a6bddc31df@molgen.mpg.de>
References: <8ecde631-9b24-b177-749c-a5a6bddc31df@molgen.mpg.de>
Message-ID: <20201008105152.00005edb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Paul Menzel wrote:
>      $ sudo ethtool -S net00
>      [?]
>      tx_smbus: 0
>      rx_smbus: 557816
>      dropped_smbus: 9
>      [?]
> 
> Out of curiosity, what are these management packets?

the rx_smbus packets matched a filter in the hardware and the packets
were redirected to the SMBUS (usually a path to the BMC for IPMI
packets) 

These packets are usually traffic on UDP port 623 (for IPMI) but
whatever host program is connected to the SMBUS can specify it's own
filters as far as I recall.

Hope this helps,
Jesse

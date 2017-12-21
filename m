From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 21 Dec 2017 12:56:58 +0100
Subject: [Intel-wired-lan] Problems with 82579LM devices in Dell
 OptiPlex990/06D7TR
Message-ID: <f97e6243-be0f-518a-e233-7788c05052b0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Intel folks,


Changing our login setup, we noticed sometimes the RPC time-out 
`do_ypcall: clnt_call: RPC: Timed out` when calling `getspnam()` on 
exactly one type of machines, Dell OptiPlex 990, with the ethernet 
device 82579LM.

Please find DMI info fetched with `dmicode -s ?`, where the string is in 
the order below, and the values separated by a hash.

bios-vendor bios-version system-manufacturer system-product-name 
system-version baseboard-product-name baseboard-version

     Dell Inc.#A11#Dell Inc.#OptiPlex 990#01#06D7TR#A01
     Dell Inc.#A11#Dell Inc.#OptiPlex 990#01#06D7TR#A01
     Dell Inc.#A10#Dell Inc.#OptiPlex 990#01#06D7TR#A01
     Dell Inc.#A07#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A07#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A07#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A07#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A07#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A07#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A05#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A05#Dell Inc.#OptiPlex 990#01#06D7TR#A00
     Dell Inc.#A03#Dell Inc.#OptiPlex 990#01#06D7TR#A00

The machines are of course out of warranty, and we guess that the 
problem was there all along (reproducible with Linux 4.4 and 4.9), but 
wasn?t noticed until now. We suspect it?s a hardware problem, as the PBA 
number of these devices is all *E041FF-0FF*. Other systems also use the 
device, but the problem is not reproducible there, for example *1011FF-0FF*.

Anyway, before digging more into this, could you please take a look into 
your internal error documents if there is a problem with that special 
82579LM assembly?

```
[    1.458794] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.459053] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.459414] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.722400] e1000e 0000:00:19.0 eth0: registered PHC clock
[    1.722653] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 
90:b1:1c:79:7b:04
[    1.723072] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network 
Connection
[    1.723403] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 
1011FF-0FF
[   13.693188] e1000e 0000:00:19.0 net00: renamed from eth0
[   16.878762] e1000e: net00 NIC Link is Up 1000 Mbps Full Duplex, Flow 
Control: Rx/Tx
```


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171221/939d0fe0/attachment.p7s>

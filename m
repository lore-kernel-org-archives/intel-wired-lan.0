From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 28 May 2019 17:42:32 +0200
Subject: [Intel-wired-lan] Driver has suspect GRO implementation,
 TCP performance may be compromised.
Message-ID: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


Occasionally, Linux outputs the message below on the workstation Dell
OptiPlex 5040 MT.

    TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised.

Linux 4.14.55 and Linux 5.2-rc2 show the message, and the WWW also
gives some hits [1][2].

```
$ sudo ethtool -i net00
driver: e1000e
version: 3.2.6-k
firmware-version: 0.8-4
expansion-rom-version: 
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no
```

Can the driver e1000e be improved?

Any idea, what triggers this, as I do not see it every boot? Download
of big files?


Kind regards,

Paul


[1]: https://access.redhat.com/solutions/3152971
     "Why following error "TCP: ensX: Driver has suspect GRO implementation, TCP performance may be compromised" are seen in system log file ?"
[2]: https://patchwork.ozlabs.org/patch/723007/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190528/848a1e22/attachment.p7s>

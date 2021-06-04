From: manty kuma <mantykuma@gmail.com>
Date: Fri, 4 Jun 2021 14:42:45 +0900
Subject: [Intel-wired-lan] igb: Random NIC down for 3-4 seconds and then UP
Message-ID: <CAB6A5-B6kH6hiOJHZ-8JY0H8PqXeab07vUGMdBvfCgGPR8QzBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We see random NIC down like shown below. It lasts for a few seconds and
then the connection is back up.

From kernel Log:
```
[ 3306.560431] igb 0000:03:00.0 enp3s0: igb: enp3s0 NIC Link is Down
[ 3309.532558] igb 0000:03:00.0 enp3s0: igb: enp3s0 NIC Link is Up 1000
Mbps Full Duplex, Flow Control: RX\/TX

[ 3337.380117] igb 0000:02:00.0 enp2s0: igb: enp2s0 NIC Link is Down
[ 3341.672189] igb 0000:02:00.0 enp2s0: igb: enp2s0 NIC Link is Up 100 Mbps
Half Duplex, Flow Control: None
```
Steps to reproduce: Unknown. Happens randomly
Frequency: once in a couple of weeks so far.

Kernel: 5.10
Firmware version: 3.25, 0x800005cf
driver: igb

Is it a known issue?
What can we do to better understand the reason for this behavior and fix it?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210604/c437d7d9/attachment.html>

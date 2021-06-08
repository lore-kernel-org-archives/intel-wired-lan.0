From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 8 Jun 2021 23:19:13 +0000
Subject: [Intel-wired-lan] igb: Random NIC down for 3-4 seconds and then
 UP
In-Reply-To: <CAB6A5-B6kH6hiOJHZ-8JY0H8PqXeab07vUGMdBvfCgGPR8QzBw@mail.gmail.com>
References: <CAB6A5-B6kH6hiOJHZ-8JY0H8PqXeab07vUGMdBvfCgGPR8QzBw@mail.gmail.com>
Message-ID: <6b36112fc1548f06a737bc7a1febaac06f799b6a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-06-04 at 14:42 +0900, manty kuma wrote:
> We see random NIC down like shown below. It lasts for a few seconds
> and then the connection is back up.
> 
> From kernel Log:
> ```
> [ 3306.560431] igb 0000:03:00.0 enp3s0: igb: enp3s0 NIC Link is Down
> [ 3309.532558] igb 0000:03:00.0 enp3s0: igb: enp3s0 NIC Link is Up
> 1000 Mbps Full Duplex, Flow Control: RX\/TX
> 
> [ 3337.380117] igb 0000:02:00.0 enp2s0: igb: enp2s0 NIC Link is Down
> [ 3341.672189] igb 0000:02:00.0 enp2s0: igb: enp2s0 NIC Link is Up
> 100 Mbps Half Duplex, Flow Control: None
> ```
> Steps to reproduce: Unknown. Happens randomly
> Frequency: once in a couple of weeks so far.
> 
> Kernel: 5.10
> Firmware version: 3.25, 0x800005cf
> driver: igb
> 
> Is it a known issue?
> What can we do to better understand the reason for this behavior and
> fix it?

Hi Manty,

I'm not aware of this as a known issue, but I've filed an internal bug
so that it can be looked into further. Could you provide the lspci info
for the device? Also, if you have any info that might be helpful such
as occuring under traffic or when idle, etc.

Thanks,
Tony

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

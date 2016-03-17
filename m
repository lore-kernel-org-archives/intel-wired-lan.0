From: zhuyj <zyjzyj2000@gmail.com>
Date: Thu, 17 Mar 2016 10:20:49 +0800
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <20160316143654.GD21307@oracle.com>
References: <20160314214333.GP5084@oracle.com> <56E7A7B6.5030209@gmail.com>
 <56E7CE18.9020004@gmail.com> <20160315105433.GC11063@oracle.com>
 <56E8D0C5.307@gmail.com> <20160316032523.GC19052@oracle.com>
 <56E94786.9090701@gmail.com> <20160316143654.GD21307@oracle.com>
Message-ID: <56EA1481.80600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 03/16/2016 10:36 PM, Sowmini Varadhan wrote:
> On (03/16/16 19:46), zhuyj wrote:
>
>> It is busy today. Tomorrow I will share the steps about pktgen tools.
> Ok. I can give that a try on my machine. It would be good to
> have some way to reproduce this as simply as possible, maybe
> we can take the discussion to netdev to see if others there
> have experienced this.
>
> --Sowmini
>
1. modprobe NET_PKTGEN

2. download the tar file and uncompress to any directory.
This tar file is from kernel. It is in samples/pktgen/

3. cd pktgen

4. pktgen_sample02_multiqueue.sh -i ethx -s size -t cpu_number

If size is set to a big number, the similar defect will occur.
Adjust this size to a appropriate number, my defect will not occur.

In the test, I found some types igb nic, such as i210, will work well no 
matter the size is a big number.
some nic, such as 82580, it will not work well if the size is too big.

As such, I think my problem results from the hardware and the big size 
triggers this problem.

I hope this can help us all.

Zhu Yanjun

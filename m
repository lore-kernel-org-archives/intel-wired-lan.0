From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 8 Jan 2021 17:26:40 -0800
Subject: [Intel-wired-lan] [RFC PATCH v2 net-next 00/12] Make
 .ndo_get_stats64 sleepable
In-Reply-To: <20210106134516.jnh2b5p5oww4cghz@skbuf>
References: <20210105185902.3922928-1-olteanv@gmail.com>
 <20210106134516.jnh2b5p5oww4cghz@skbuf>
Message-ID: <e0edda65-5421-94aa-19c5-1bd88a602f92@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/6/2021 5:45 AM, Vladimir Oltean wrote:
> On Tue, Jan 05, 2021 at 08:58:50PM +0200, Vladimir Oltean wrote:
>> This is marked as Request For Comments for a reason.
> 
> If nobody has any objections, I will remove the memory leaks I
> introduced to check if anybody is paying attention, and I will resubmit
> this as a non-RFC series.
> 

I read through this, and it makes sense to me. I admit that I still
don't grasp all the details of the locking involved.

Thanks,
Jake

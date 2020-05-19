From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 19 May 2020 15:53:26 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <158992801438.36166.9692784713665851855@twxiong-mobl.amr.corp.intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516093317.GJ21714@lion.mk-sys.cz> <87sgfxox4x.fsf@intel.com>
 <158992801438.36166.9692784713665851855@twxiong-mobl.amr.corp.intel.com>
Message-ID: <875zcro7tl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Andre Guedes <andre.guedes@intel.com> writes:

>> >
>> >>      active: active
>> >>      supported queues: 0xf
>
> Following the same rationale, is this 'supported queue' going aways as well?
>

I think so, with good error messages, when trying to set an express-only
queue as preemptible, no need to expose this information.


-- 
Vinicius

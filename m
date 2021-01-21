From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Jan 2021 15:18:56 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 6/8] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <20210119182352.17635829@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
 <20210119004028.2809425-7-vinicius.gomes@intel.com>
 <20210119182352.17635829@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <87v9bpx4in.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 18 Jan 2021 16:40:26 -0800 Vinicius Costa Gomes wrote:
>> +		NL_SET_ERR_MSG(extack, "Invalid value for add-frag-size");
>
> NL_SET_ERR_MSG_MOD

Will fix. Thanks.


Cheers,
-- 
Vinicius

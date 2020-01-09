From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 9 Jan 2020 10:48:26 -0800
Subject: [Intel-wired-lan] [PATCH 0/4] devlink region snapshot triggering
In-Reply-To: <20200109070051.GA2235@nanopsycho.orion>
References: <20200109010818.1326575-1-jacob.e.keller@intel.com>
 <20200109070051.GA2235@nanopsycho.orion>
Message-ID: <c342b0c0-96e0-73fa-43b9-5544ec5195a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/8/2020 11:00 PM, Jiri Pirko wrote:
> Thu, Jan 09, 2020 at 02:08:15AM CET, jacob.e.keller at intel.com wrote:
>> There is also some fix ups for s/shapshot/snapshot/ in documentation
>> and the devlink_snapshot_id_get function.
> 
> You can already trigger health reporter dump from userspace. Why don't
> you use health reporter?
> 

Hmm. Mainly because the specific things I wanted to expose through
regions aren't really "health" information.

Thanks,
Jake

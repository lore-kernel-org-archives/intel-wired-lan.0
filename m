From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 29 Jan 2021 23:37:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 0/8] ethtool: Add support
 for frame preemption
In-Reply-To: <20210122224453.4161729-1-vinicius.gomes@intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
Message-ID: <20210129233729.bjckcxcx45hueb2z@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 22, 2021 at 02:44:45PM -0800, Vinicius Costa Gomes wrote:
> This is still an RFC because two main reasons, I want to confirm that
> this approach (per-queue settings via qdiscs, device settings via
> ethtool) looks good, even though there aren't much more options left ;-)

I don't want to bother you too much, but a consequence of putting the
per-priority settings into tc-taprio is that those will spill over into
other qdiscs too that have nothing to do with TSN, for whomever will
need frame preemption without time-aware scheduling (and there are
reasons to want that).
So could we see in the next version the frame preemption bits added to
tc-mqprio as well? I just want to make sure that we run this by the tc
maintainers and that the idea gets their informed consent before we end
up in a position where frame preemption with time-aware scheduling is
done in one way, but frame preemption without time-aware scheduling is
done another way.
You should not need to change anything related to TC_SETUP_PREEMPT in
the igc driver, so it should be just code addition.

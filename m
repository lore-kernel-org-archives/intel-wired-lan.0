From: Stefan Assmann <sassmann@kpanic.de>
Date: Tue, 24 Aug 2021 10:25:24 +0200
Subject: [Intel-wired-lan] [bug report] iavf: use mutexes for locking of
 critical sections
In-Reply-To: <20210824081039.GA16756@kili>
References: <20210824081039.GA16756@kili>
Message-ID: <74732a5e-b9c4-c119-ea38-b604e252ec33@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 24.08.21 10:10, Dan Carpenter wrote:
> Hello Stefan Assmann,
> 
> The patch 5ac49f3c2702: "iavf: use mutexes for locking of critical
> sections" from Aug 4, 2021, leads to the following
> Smatch static checker warning:

Thanks for the report, I'll take a look!

  Stefan

> 	drivers/net/ethernet/intel/iavf/iavf_main.c:2019 iavf_watchdog_task()
> 	error: double unlocked '&adapter->crit_lock' (orig line 1968)
> 
> drivers/net/ethernet/intel/iavf/iavf_main.c
>     1932 static void iavf_watchdog_task(struct work_struct *work)
>     1933 {
>     1934 	struct iavf_adapter *adapter = container_of(work,
>     1935 						    struct iavf_adapter,
>     1936 						    watchdog_task.work);
>     1937 	struct iavf_hw *hw = &adapter->hw;
>     1938 	u32 reg_val;
>     1939 
>     1940 	if (!mutex_trylock(&adapter->crit_lock))
>     1941 		goto restart_watchdog;
>     1942 
>     1943 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
>     1944 		adapter->state = __IAVF_COMM_FAILED;
>     1945 
>     1946 	switch (adapter->state) {
>     1947 	case __IAVF_COMM_FAILED:
>     1948 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
>     1949 			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
>     1950 		if (reg_val == VIRTCHNL_VFR_VFACTIVE ||
>     1951 		    reg_val == VIRTCHNL_VFR_COMPLETED) {
>     1952 			/* A chance for redemption! */
>     1953 			dev_err(&adapter->pdev->dev,
>     1954 				"Hardware came out of reset. Attempting reinit.\n");
>     1955 			adapter->state = __IAVF_STARTUP;
>     1956 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
>     1957 			queue_delayed_work(iavf_wq, &adapter->init_task, 10);
>     1958 			mutex_unlock(&adapter->crit_lock);
>     1959 			/* Don't reschedule the watchdog, since we've restarted
>     1960 			 * the init task. When init_task contacts the PF and
>     1961 			 * gets everything set up again, it'll restart the
>     1962 			 * watchdog for us. Down, boy. Sit. Stay. Woof.
>     1963 			 */
>     1964 			return;
>     1965 		}
>     1966 		adapter->aq_required = 0;
>     1967 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>     1968 		mutex_unlock(&adapter->crit_lock);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Unlocked here
> 
>     1969 		queue_delayed_work(iavf_wq,
>     1970 				   &adapter->watchdog_task,
>     1971 				   msecs_to_jiffies(10));
>     1972 		goto watchdog_done;
>                         ^^^^^^^^^^^^^^^^^^^
> Goto
> 
>     1973 	case __IAVF_RESETTING:
>     1974 		mutex_unlock(&adapter->crit_lock);
>     1975 		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
>     1976 		return;
>     1977 	case __IAVF_DOWN:
>     1978 	case __IAVF_DOWN_PENDING:
>     1979 	case __IAVF_TESTING:
>     1980 	case __IAVF_RUNNING:
>     1981 		if (adapter->current_op) {
>     1982 			if (!iavf_asq_done(hw)) {
>     1983 				dev_dbg(&adapter->pdev->dev,
>     1984 					"Admin queue timeout\n");
>     1985 				iavf_send_api_ver(adapter);
>     1986 			}
>     1987 		} else {
>     1988 			/* An error will be returned if no commands were
>     1989 			 * processed; use this opportunity to update stats
>     1990 			 */
>     1991 			if (iavf_process_aq_command(adapter) &&
>     1992 			    adapter->state == __IAVF_RUNNING)
>     1993 				iavf_request_stats(adapter);
>     1994 		}
>     1995 		break;
>     1996 	case __IAVF_REMOVE:
>     1997 		mutex_unlock(&adapter->crit_lock);
>     1998 		return;
>     1999 	default:
>     2000 		goto restart_watchdog;
>     2001 	}
>     2002 
>     2003 		/* check for hw reset */
>     2004 	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
>     2005 	if (!reg_val) {
>     2006 		adapter->flags |= IAVF_FLAG_RESET_PENDING;
>     2007 		adapter->aq_required = 0;
>     2008 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>     2009 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
>     2010 		queue_work(iavf_wq, &adapter->reset_task);
>     2011 		goto watchdog_done;
>     2012 	}
>     2013 
>     2014 	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
>     2015 watchdog_done:
>     2016 	if (adapter->state == __IAVF_RUNNING ||
>     2017 	    adapter->state == __IAVF_COMM_FAILED)
>     2018 		iavf_detect_recover_hung(&adapter->vsi);
> --> 2019 	mutex_unlock(&adapter->crit_lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Double unlock.
> 
>     2020 restart_watchdog:
>     2021 	if (adapter->aq_required)
>     2022 		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
>     2023 				   msecs_to_jiffies(20));
>     2024 	else
>     2025 		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
>     2026 	queue_work(iavf_wq, &adapter->adminq_task);
>     2027 }
> 
> regards,
> dan carpenter
> 


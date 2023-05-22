#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress.
"""
import requests
import sys

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: {} employee_id".format(sys.argv[0]))
        sys.exit(1)

    employee_id = sys.argv[1]
    base_url = "https://jsonplaceholder.typicode.com"
    user_url = "{}/users/{}".format(base_url, employee_id)
    todo_url = "{}/todos?userId={}".format(base_url, employee_id)

    try:
        user_response = requests.get(user_url)
        todo_response = requests.get(todo_url)

        employee_name = user_response.json().get('name')
        todo_list = todo_response.json()

        completed_tasks = [task for task in todo_list if task.get('completed')]
        total_tasks = len(todo_list)
        completed_tasks_count = len(completed_tasks)

        print("Employee {} is done with tasks ({}/{}):".format(
            employee_name,
            completed_tasks_count,
            total_tasks
        ))
        for task in completed_tasks:
            print("\t{}".format(task.get('title')))

    except requests.exceptions.RequestException as e:
        print("An error occurred:", e)
        sys.exit(1)
